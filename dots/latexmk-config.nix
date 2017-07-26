with import <nixpkgs> {};

pkgs.writeText "LatexMk" ''
  $pdf_mode = 1;
  $pdflatex = 'xelatex --shell-escape %O %S';

  my $bib_program = 'bibtex';
  if ( -e "4bbl_base.bcf" ) {
      $bib_program = 'biber';
  }
''
