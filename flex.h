#ifdef FAST
#define PARM_NO_FLEX 1
#endif

//#define _GNU_SOURCE // enable reallocarray

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <stdint.h> // C99

#ifndef __FLEX_H__
#define __FLEX_H__ 1

/*

    This package supports dynamic array sizing - the initially-declared array
  has no RAM allocated.  When an array element is written to, enough RAM is
  allocated to at least allow that element to exist.  Writing to array elements
  beyond the farthest existing element causes the RAM to be extended.  Reading
  from an array element beyond the farthest existing element triggers a runtime
  'array bound' error report.  Reading from an array element for which RAM has
  been allocated, but which is unassigned, triggers a runtime 'unassigned
  variable' error report.

  To use this mechanism efficiently it is STRONGLY recommended that array
  elements are always accessed by indexing, NOT by pointers.  The array
  extensions work by calls to 'realloc', so pointers to elements may no
  longer point to the same element after a reallocation of RAM.  Although
  in principle a programmer could relocate any active pointers into these
  areas, a smart programmer would simply use indexes into the arrays from
  the start and avoid the problem.

  The package works by using macros to declare the flex arrays, and replacing
  indexed array accesses such as fred[p] by macro call such as 'fred(p)'.

  In order to handle reads and writes of array elements correctly, the
  form '_fred(p)' must be used when the array elements is being written 
  to, as when it appears on the LHS of an assingment.

  References to the base of the array, such as 'fred', should be replaced
  by '&fred(0)'.

  These limitations are not very onerous and quickly become second nature.
  The benefit in simplicity of memory management coupled with improved
  error detection far outweigh the extra coding effort needed

  To avoid excessive resizing, the RAM is allocated in powers of two, so
  an array that only required elements 0 through 99 would actually have space
  allocated for elements 0 through 127.

  Unassigned variable checking is done by initializing data to a seldom-used
  bit pattern.  We could potentially use an 'initialized[]' bit vector if this
  proves problematic, however we have decades of experience using the same
  technique with Imp compilers where it has not been a problem.

  Currently only 1-dimensional arrays are supported.
  Not sure yet whether we will be able to pass these as parameters.
  Type information is being added explicitly in the READ and WRITE
  macros - could probably use typeof() and remove an extra parameter.

  Note: although there is some support for flex arrays in C99, and also in
  some GNU extensions to gcc, this package does not use them.  It is compatible
  with older versions of C which are not consistent in their  support for flex
  arrays. ( You can read more on the semi-official ways to handle flex arrays
  in https://people.kernel.org/kees/bounded-flexible-arrays-in-c )
 */

// Effectively an external dope-vector.  In principle could extend to more dimensions
// but this was sufficient for Imp to C project so keeping it simple.

typedef struct FLEX {  // The name 'flex' comes from Algol 68's flex array type.
  void *element;       // pointer to actual array menory
  int element_size;    // Should match the alignment of regular arrays.  Relevant for structs.
  int next_free_index; // element immediately after maximum element for which RAM is allocated
  int last_used_index; // highest used index
  int maxelements;     // Used if static, or to limit dynamic growth.
  char *name;          // name of array, used only in error and diagnostic messages
} FLEX;

typedef uintptr_t ADDRESS;

#define UNASSIGNED 0x80808080
#define unassigned 0x80808080

// The unassigned variable check and the simple array bounds check are inline
// to reduce the time overhead of checking. The error message is printed by a
// parameterless external procedure to reduce the space overhead per test.

extern void UERR(void); // print "Unassigned Variable" error message.
#ifdef FAST
#define U(x) (x)
#else
static inline int U(register int U) {
  if (U == UNASSIGNED) UERR();
  return U;
}
#endif

extern int STATIC_BOUNDS_ERROR(int idx, int Lim, char *name);

static inline int STATIC_CHECK(int idx, int Lim, char *name) {
  if (idx >= Lim) STATIC_BOUNDS_ERROR(idx, Lim, name);
  return idx;
}
#ifdef FAST
#define BOUNDS_CHECK(Array,Idx,Lim) Array[Idx]
#else
#define BOUNDS_CHECK(Array,Idx,Lim) Array[STATIC_CHECK(Idx,Lim,#Array)]
#endif

extern int PARM_UNASS_CHECK;
extern int PARM_BOUNDS_CHECK;
extern int flexdebug;

ADDRESS Check_Flex_Array_Bound(int x, FLEX *Object, char *file, int line);

ADDRESS Extend_Flex_Array_Bound(int x, FLEX *Object, char *file, int line);

// If we're not using flex arrays, we still need a way to declare a simple array with fixed initial size.
#ifdef PARM_NO_FLEX
// Fall back to regular arrays.

#define DECLARE(name, type, maxelements) type name[maxelements]
#define SPEC(arrayname, type) type arrayname[]
#define FREE_FLEX(Object)
#define WRITE(Index,Array,type) Array[Index]
#define  READ(Index,Array,type) Array[Index]

#else

// I guess the alignment below isn't guaranteed to be portable:
//    .element_size = (sizeof(type) == 1 ? 1 : (3+sizeof(type)) & (~3)),

#define DECLARE(arrayname, type, max_elements) \
  FLEX arrayname = {                           \
    .element = NULL,                           \
    .element_size = sizeof(type),              \
    .next_free_index = 0,                      \
    .last_used_index = -1,                     \
    .maxelements = max_elements,               \
    .name = #arrayname                         \
  }
#define SPEC(arrayname, type) FLEX arrayname

// The flex block itself obeys scope rules but its RAM which comes off the heap does not, so we may need to free the RAM ourselves in some cases.
// Potentially could consider alloca() instead of malloc() to avoid the need to explicitly free data that we are done using at the end of a block.
#define FREE_FLEX(arrayname) do if (arrayname.element) { \
      free(arrayname.element); \
      /*fprintf(stderr, "Flex: %s used %d bytes\n", #arrayname, arrayname.next_free_index * arrayname.element_size);*/ \
      arrayname.next_free_index = 0; \
      arrayname.last_used_index = -1; \
} while(0)

#define WRITE(Index,Array,type) (*(type *)Extend_Flex_Array_Bound(Index,&Array,__FILE__, __LINE__))
#define  READ(Index,Array,type) (*(type *) Check_Flex_Array_Bound(Index,&Array,__FILE__, __LINE__))

#endif // PARM_NO_FLEX

// to do: add wrapper for simple array bound checking

#endif // __FLEX_H__
