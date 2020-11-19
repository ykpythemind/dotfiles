complete -c ag -s -C -l context -d 'Print lines before and after matches (Default: 2)'

complete -c ag -s -g -l filename-pattern -d 'Print filenames matching PATTERN'

complete -c ag -s -v -l invert-match -d 'Invert match'

complete -c ag -s -G -l file-search-regex -d 'Limit search to filenames matching PATTERN'
complete -c ag -s -Q -l literal -d 'Dont parse PATTERN as a regular expression'

complete -c ag -l ignore -d 'Ignore files/directories matching PATTERN (literal file/directory names also allowed)'

