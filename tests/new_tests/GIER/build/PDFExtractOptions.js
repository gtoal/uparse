export interface PDFExtractOptions {
  firstPage?: number; // default:`1` - start extract at page nr
  lastPage?: number; //  stop extract at page nr, no default value
  password?: string; //  for decrypting password-protected PDFs., no default value
  verbosity?: number; // default:`-1` - log level of pdf.js
  normalizeWhitespace?: boolean; // default:`false` - replaces all occurrences of whitespace with standard spaces (0x20).
  disableCombineTextItems?: boolean; // default:`false` - do not attempt to combine  same line {@link TextItem}'s.
}
