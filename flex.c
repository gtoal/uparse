#ifdef FAST
#define PARM_NO_FLEX 1
#endif

// THIS PACKAGE IS DESCRIBED IN flex.h

#include "flex.h"

#ifndef _GNU_SOURCE
#define reallocarray(optr, nmemb, size) realloc((optr), (size) * (nmemb))
#endif

// Flex array bounds and unassigned checking initially turned on with -du or -da
// but after fixing bug that slowed down unassigned checking by a ridiculous amount,
// I'm turning these on by default because the checking overhead is now unnoticeable.
// Trust me, you'll thank me for this the first time it catches a real bug for you.

int PARM_UNASS_CHECK = 1;
int PARM_BOUNDS_CHECK = 1;

int flexdebug = 0; // only affects reporting, not run-time checks.
static int array_bound = 2, unassigned_variable = 1, error = 0;
void UERR(void) {
  fprintf(stderr, "* UNASSIGNED VARIABLE (More info available if using gdb)\n");
  unassigned_variable/=error; // in gdb, see where an unassigned variable was accessed by typing:  up 2
  // Forcing entry into gdb is cheaper than passing the source file/line number as explicit parameters.
  // If the source is liberally sprinkled with unassigned checks, the overhead would be quite expensive
  exit(EXIT_FAILURE);
}

int STATIC_BOUNDS_ERROR(int Idx, int Lim, char *name) {
  fprintf(stderr, "* ARRAY BOUNDS EXCEEDED - %s[%d] is outside the range of %s[0:%d] (More info available if using gdb)\n", name, Idx, name, Lim-1);
  array_bound/=error; // in gdb, see where the array index was out of range by typing:  up 2
  // Forcing entry into gdb is cheaper than passing the source file/line number as explicit parameters.
  // If the source is liberally sprinkled with unassigned checks, the overhead would be quite expensive
  exit(EXIT_FAILURE);
}


// In the checks below, we *do* pass in the filename and line number,
// so there is no need to force entry into the debugger.

ADDRESS Check_Flex_Array_Bound(int x, FLEX *Object, char *file, int line) {
  // This is used when reading from a flex array.  It errors if the array index
  // is out of range, or if the element is unassigned. 

  if (PARM_UNASS_CHECK) { // on the index
    if (x == UNASSIGNED) {
      fprintf(stderr, "\"%s\", Line %d: Reading from %s[<Unassigned variable>]\n",
              file, line, Object->name);
      unassigned_variable/=error; // in gdb, see where the array was accessed by typing: up 2
      exit(EXIT_FAILURE); // or force a backtrace?
    }
  }
  
  if (PARM_BOUNDS_CHECK) { // index out of range?
    if ((x < 0) || (x > Object->last_used_index)) {
      fprintf(stderr, "\"%s\", Line %d: Reading from %s[%d] - array bounds exceeded - range is 0:%d\n",
              file, line, Object->name, x, Object->last_used_index);
      // to do: add a note that _%s[] should have been used instead of %s[], if you got this error
      // when checking a LHS.
      array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
      exit(EXIT_FAILURE);
    }
  }

  void *Element = (void *)(Object->element + (x*Object->element_size));

  if (PARM_UNASS_CHECK) { // on the element
    if (UNASSIGNED == *(int *)Element) {
      fprintf(stderr, "\"%s\", Line %d: Reading from %s[%d] - Unassigned variable\n",
              file, line, Object->name, x);
      array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
      exit(EXIT_FAILURE); // or force a backtrace?
    }
  }

  return (ADDRESS)Element;
}

ADDRESS Extend_Flex_Array_Bound(int x, FLEX *Object, char *file, int line) {
  // This one is only used when writing to the flex array.  It extends the size of
  // the array if needed, and fills in unused elements with the unassigned pattern.

  if (x < 0) {
    fprintf(stderr, "\"%s\", Line %d: Writing to %s[%d] - array bounds exceeded - range is 0:%d\n",
            file, line, Object->name, x, Object->last_used_index);
    // array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
    exit(EXIT_FAILURE); // or force a backtrace?
  }

  // If x is within current extent, we don't need to realloc.
  if (x >= Object->next_free_index) {
    int base_offset, added_size;
    if (flexdebug) fprintf(stderr, "Object->next_free_index = %d\n", Object->next_free_index);
    if (flexdebug) fprintf(stderr, "Extend_Flex_Array_Bound(%d, %p)\n", x, Object);
    base_offset = ((Object->next_free_index) * Object->element_size); // initially is 0, later becomes size of allocated RAM (in bytes)
                                                                        // because initial next_free_index is -1
    if (flexdebug) fprintf(stderr, "base offset = %d\n", base_offset);
    if (Object->next_free_index == Object->maxelements) {
      fprintf(stderr, "\"%s\", Line %d: Cannot extend flex array beyond upper limit of %d\n", file, line, Object->maxelements);
      // array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
      exit(EXIT_FAILURE);
    }

    while (x >= Object->next_free_index) Object->next_free_index = (Object->next_free_index*2)+1;
    if (Object->next_free_index > Object->maxelements) Object->next_free_index = Object->maxelements;
    added_size = ((Object->next_free_index+1) * Object->element_size) - base_offset;

    if (x >= Object->next_free_index) {
      fprintf(stderr, "\"%s\", Line %d: Cannot extend flex array %s[0:%d] to accommodate  %s[%d].\n",
                        file,  line, Object->name, Object->maxelements-1,       Object->name, x);
      // array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
      exit(EXIT_FAILURE);
    }
    
    if (!Object->element) {
      if (flexdebug) fprintf(stderr, "initial size = %d (%d * %d = %d)\n", added_size, Object->next_free_index+1,       Object->element_size,         ((Object->next_free_index+1)*Object->element_size));
      Object->element = malloc(added_size);
      if (flexdebug) fprintf(stderr, "%s[%d]: malloc(Object->next_free_index+1 = %d * Object->element_size = %d  -> %d) -> %p\n",
                            Object->name, x,          Object->next_free_index+1,       Object->element_size,         ((Object->next_free_index+1)*Object->element_size),
                                                                                                                            Object->element);
      if (Object->element == NULL) {
        fprintf(stderr, "\"%s\", Line %d: Writing to %s[%d] - alloc fails - %s\n",
                           file, line,     Object->name, x,                 strerror(errno));
        // malloc_failure/=error; // in gdb, see where the array bound was exceeded by typing: up 2
        exit(EXIT_FAILURE);
      }
    } else {
      void *new;
      if (flexdebug) fprintf(stderr, "added_size = %d, total size = (%d * %d = %d)\n", added_size, Object->next_free_index+1, Object->element_size, (Object->next_free_index+1)*(Object->element_size));
      if (flexdebug) fprintf(stderr, "%s[%d]: reallocarray(Object->element = %p, Object->next_free_index+1 = %d, Object->element_size = %d)",
                             Object->name,x,                Object->element,      Object->next_free_index+1,      Object->element_size);
      new = reallocarray(Object->element, Object->next_free_index+1, Object->element_size);
                                                                  // ^ This is the final total size, not the delta addition
      if (new) {
        Object->element = new;
        if (flexdebug) fprintf(stderr, " -> %p\n", new);
      } else {
        if (flexdebug) fprintf(stderr, "\n");
        fprintf(stderr, "\"%s\", Line %d: Writing to %s[%d] - reallocarray fails - %s\n",
                           file, line,     Object->name, x,                        strerror(errno));
        // array_bound/=error; // in gdb, see where the array bound was exceeded by typing: up 2
        exit(EXIT_FAILURE);
      }
    }
      
    if (PARM_UNASS_CHECK) { // Fill the array with 'unassigned' pattern (0x80808080)
      if (flexdebug) fprintf(stderr, "memset(%p,%02x,%d);\n", Object->element + base_offset, UNASSIGNED&0xFF, added_size);
      memset(Object->element + base_offset, UNASSIGNED&0xFF, added_size);
    }
  } else {
    //fprintf(stderr, "Extension without reallocation for %d\n", x);
  }

  if (x > Object->last_used_index) Object->last_used_index = x;
  return (ADDRESS)Object->element + (x * Object->element_size);
}
