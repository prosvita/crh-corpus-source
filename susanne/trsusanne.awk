BEGIN {
    OFS="	"
    prevfile="<start>"
}

FILENAME != prevfile {
    if (prevfile != "<start>") {print "</doc>"}
    prevfile=FILENAME
    docnum=1
    basename=FILENAME
    sub(/.*\//, "", basename)
    print "<doc file=\"" basename "\" n=" docnum ">"
}

END {print "</doc>"}

# begin of sentence
#$6 ~ /\[S[:.[]/ {print "<s>"}


$4 ~ /^\+/ {print "<g/>";$4 = substr ($4,2)}

{
    if ($4 == "<docbrk>") {
	docnum++;
	print "<doc file=\"" basename "\" n=" docnum ">";
    }
  else if ($4 ~ /<m[ai][jn]brk>/)
      print "<p>"
  else if ($4 ~ /bm[ai][jn]hd>/)
      # XXX zahazujeme cenne informace z dalsich atributu!
      print "<head type=" substr ($4,3,3) ">"
  else if ($4 ~ /em[ai][jn]hd>/)
      print "</head>"
  else if ($4 == "<bbold>" || $4 == "<bital>")
      print "<font type=" substr ($4,3,4) ">"
  else if ($4 == "<ebold>" || $4 == "<eital>")
      print "</font>"
  else if ($4 != "-") {
      gsub(/<eacute>/,"\351",$4)
      gsub(/<egrave>/,"\350",$4)
      gsub(/<iuml>/,"\357",$4)
      gsub(/<ccedil>/,"\247",$4)
      gsub(/<ouml>/,"\366",$4)
      gsub(/<ntilde>/,"\361",$4)
      gsub(/<agrave>/,"\340",$4)
      gsub(/<oelig>/,"oe",$4)
      gsub(/<auml>/,"\344",$4)

      gsub(/<hyphen>/,"-",$4) 
      gsub(/<apos>/,"'",$4)
      sub(/<dollar>/,"$",$4)
      sub(/<mdash>/,"--",$4)
      sub(/<minus>/,"-",$4)
      sub(/<deg>/,"\260",$4)
      sub(/<ldquo>/,"\"",$4)
      sub(/<rdquo>/,"\"",$4)
      sub(/<lsquo>/,"'",$4)
      sub(/<rsquo>/,"`",$4)

      gsub(/<blank>/," ",$5)
      gsub(/<hyphen>/,"-",$5) 
      gsub(/<apos>/,"'",$5)

      gsub(/<eacute>/,"\351",$5)
      gsub(/<egrave>/,"\350",$5)
      gsub(/<iuml>/,"\357",$5)
      gsub(/<ccedil>/,"\247",$5)
      gsub(/<ouml>/,"\366",$5)
      gsub(/<ntilde>/,"\361",$5)
      gsub(/<agrave>/,"\340",$5)
      gsub(/<oelig>/,"oe",$5)
      gsub(/<auml>/,"\344",$5)

      print $4,$5,$3,$2
  }
}

# end of sentence
#$6 ~ /[^:]S(:[A-Z][0-9]*)?\]/ {print "</s>"}
