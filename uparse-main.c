int main(int argc, char **argv) {
  // I've started adding some support for AST objects in takeon.  Not yet fully developed.
  int CST_root = UNASSIGNED;   // root of program CST starting from Phrase "SS".  (Source Statement - historical name from AA grammar)
  int AST_root = UNASSIGNED;   // root of program AST starting from Phrase "SS".
  int fp = 0; // file pointer for saving UTF32
  int TP = 0; // Text pointer for parse
  int i;
  
  // Extract Program name for error messages.  Bit of a hack but hasn't failed yet. 
  char *ProgName, *s;
  ProgName = strdup(argv[0]);
  if ((s = strrchr(ProgName, '/')) != 0) ProgName = ++s;  // linux
  if ((s = strrchr(ProgName, '\\')) != 0) ProgName = ++s; // windows/DOS
  if ((s = strrchr(ProgName, ']')) != 0) ProgName = ++s;  // VMS
  if ((s = strrchr(ProgName, ';')) != 0) *s = '\0';       // VMS version no's
  if ((s = strrchr(ProgName, '.')) != 0) *s = '\0';       // all .exe extensions etc. Except Acorn RiscOS :-(

#ifdef _INCL_MNEMOSYNE_H
  mnem_init(argv[0]);
#endif

#ifdef FAST
  PARM_UNASS_CHECK = 0;
  PARM_BOUNDS_CHECK = 0;
#endif
  
  /* If your native locale doesn't use UTF-8 encoding,
   * you may need to replace the empty string with a
   * locale such as "en_US.utf8":
   */
  /* char *locale = */ (void) setlocale(LC_ALL, "");

#ifdef APPMODULE
  //fprintf(stderr, "DEBUG: appmodule = %s\n", APPMODULE);
#endif

  while (argc >= 2) {
    if (strcmp(argv[1], "-d") == 0) { // they're not very mnemonic but they're primarily for me during development.
      argv += 1;
      argc -= 1;
      debug_parser = TRUE;
      debug_completion = TRUE;
      PARM_UNASS_CHECK = 1;  // - REDUNDANT - ON BY DEFAULT
      PARM_BOUNDS_CHECK = 1; // ditto
    } else if (strcmp(argv[1], "-dp") == 0) { // 'P'arse trace
      argv += 1;
      argc -= 1;
      debug_parser = TRUE;
    } else if (strcmp(argv[1], "-dc") == 0) { // 'C'ompletion status monitoring
      argv += 1;
      argc -= 1;
      debug_completion = TRUE;
    } else if (strcmp(argv[1], "-da") == 0) { // 'A'rray check   - REDUNDANT - ON BY DEFAULT
      argv += 1;
      argc -= 1;
      PARM_BOUNDS_CHECK = 1;
    } else if (strcmp(argv[1], "-du") == 0) { // 'U'nassigned check   - REDUNDANT - ON BY DEFAULT
      argv += 1;
      argc -= 1;
      PARM_UNASS_CHECK = 1;
#ifdef APPMODULE
    } else if ((strcmp(APPMODULE, "algol60-indent.c") == 0) && (strcmp(argv[1], "-jff") == 0)) {
      extern int jff;
      argv += 1;
      argc -= 1;
      jff = TRUE;
#endif
    } else break;
  }
  
  if (argc != 2) {
    fprintf(stderr, "Syntax: %s [-d[cpau]] file\n", ProgName);
    exit(1);
  }

  // Convert source file (in UTF-8) to UTF-32 array.
  FILE *f = fopen(argv[1], "r");
  if (!f) {
    fprintf(stderr, "%s: cannot open \"%s\" - %s\n", ProgName, argv[1], strerror(errno));
    exit(1);
  }
  for (;;) {
    int LC = fgetwc(f);
    if (LC == WEOF) break;
    if (ferror(f)) { fprintf(stderr, "%s: error reading \"%s\" - %s\n", ProgName, argv[1], strerror(errno)); exit(1); }
    _source(fp++) = LC;
  }
  _source(fp) = 0; // (our internal EOF code)

  // pre-compile regexps for speed:  - in header file as: const wchar_t *regexps[] = {...};
  regexp *r[NUM_REGEXPS];
  RR = r;
  for (i = 0; i < NUM_REGEXPS; i++) {
    if ((r[i] = regcomp(regexps[i])) == NULL) { fprintf(stderr, "%s: failed to precompile regexps[%d]\n", ProgName, i); exit(1); }
  }
  
  // Parse; stop and report on first error.  We've defined the grammar to parse the entire program
  // although it is an option to parse a line at a time, in which case the call to parse(SS) must
  // be put in a loop.
  //
  // Root of compile will be 2.  I had to leave two slots free to represent <?phrase> and failure.

  TP = 0;
  (void)literal_descriptor(0,0); // BUG FIX!!! DO NOT REMOVE THIS LINE.  'Matched' was getting set to the index of the literal, but index 0 implied failure.
  
  _CST(CSTidx++) = G_SS;
  _CST(CSTidx++) = 0;
  
  if ((CST_root=parse(&TP, G_SS | PHRASE_TYPE | WHITESPACE_ALLOWED, 0)) != 0) { // construct a phrase definition for root of tree.
    if (TP < fp) {
      if (debug_completion) fprintf(stderr, "\n");
      while (TP < fp) {
        fprintf(stderr, "%lc", source(TP));
        TP++;
      }
      fprintf(stderr, "%s: parsed \"%s\" OK up to this point, where parsing stopped:\n", ProgName, argv[1]);
      exit(1);
    } else {
      if (debug_completion) fprintf(stderr, "\n");
      fprintf(stderr, "%s: parsed \"%s\" successfully\n", ProgName, argv[1]);

      // Unless we ask for a compiler pass, the parser simply acts as a syntax checker.
      // Trade one tree for another.  The overhead isn't that high and it's easier
      // to work in the AST than it is in the CST.  Although traditionally all Edinburgh
      // compilers have generated code directly from the CST, I strongly recommend that
      // new programs work from the AST.
      AST_root = build_ast(CST_root); FREE_FLEX(CST); // Throw away the CST as soon as it is converted to an AST.

#ifdef APPCOMMAND
      APPCOMMAND (AST_root, 0); // User-supplied specific application. Needs to be passed in via, for example, -DAPPCOMMAND=reindent
#else
      walk_ast(AST_root, 0); // default tree-walking procedure is to re-output the source from the AST.
#endif

      // fprintf(stderr, "CST USED: %d  AST USED: %d\n", CSTidx, AST_nextfree);
      // fprintf(stderr, "MAX DEPTH: %d\n", RECURSION_MAX_DEPTH);
    }
  } else {
    if (debug_completion) fprintf(stderr, "\n");
    // To do: change error format so that EMACS can execute this code and immediately
    // step to the error:   "File", Line nnn: error
    // Actually "File":line:col format may be a better choice.

    //fprintf(stderr, "%s: syntax error while parsing \"%s\"\n", ProgName, argv[1]);
    // TO DO: Keep a 'while looking for' stack as per previous parser implementation.
    //        to give a clue as to the problem when there's an error.  Also maybe
    //        some sort of override, so that guards such as rejecting a label before
    //        a comment will output a more apposite error message.

    if (U(BestTPOK) == 0) {
      fprintf(stderr, "%s:%d:%d: error: Syntax: ", argv[1], 0,0);
      fprintf(stderr, "The file %s may not be the correct sort of input file for this program?\n", argv[1]);
    } else if (U(BestTPOK) > 0) {
      int errorline = 1;
      int startline = 0;
      int textpos = 0;
      int column = 0;
      for (;;) {
        if (source(textpos) == '\n') { errorline += 1; startline = textpos+1; }
        if (textpos == BestTPOK) break;
        textpos += 1;
      }
      i = startline;

      // Tweak for parse fail in middle of underlined character:
      if (source(BestTPOK) == L'\u0332' /*COMBINING LOW LINE*/) BestTPOK -= 1;
      for (textpos = startline; textpos < BestTPOK; textpos++) {
        if (source(textpos) != L'\u0332') column++;
      }
      fprintf(stderr, "%s:%d:%d: error: Syntax\n", argv[1], errorline, column+1);
      
      if (BestTPFail <= BestTPOK+1) BestTPFail = -1;
      
      if ((column == 0) && (startline > 1)) {
        // Error was at the start of the line.  Show the line before.
        int prev = startline-1;
        for (;;) {
          if (prev == 0) break;
          prev -= 1;
          if (source(prev) == '\n') {
            prev += 1;
            break;
          }
        }
        if (prev < startline-1) {
          for (;;) {
            if (prev == startline) break;
            fprintf(stderr, "%lc", source(prev));
            prev += 1;
          }
        }
      }
      
      for (;;) {
        if (i == fp) break;
        if (((i == BestTPOK) || (i == BestTPFail)) && (source(i) != '\n')) fputc('^', stderr);
        fprintf(stderr, "%lc", source(i));
        if (source(i) == '\n') break;
        i++;
      }

      if (i < fp && i == BestTPOK) {
        // Error was at the end of line.  Show the line after.
        fputc('^', stderr);
        for (;;) {
          fprintf(stderr, "%lc", source(i));
          i++;
          if (i == fp || source(i) == '\n') break;
        }
      }
      
      if (i == fp) fputc('\n', stderr);
      
    }
    exit(1);
  }

  exit(0);
}

