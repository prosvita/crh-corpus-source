CORPUS = susanne
ATTRIBUTES = word lemma tag status
STRUCTURES = doc p head font g 

source: trsusanne.awk
	awk -f trsusanne.awk fc/[A-N][0-9][0-9] >$@
corpus: source
	encodevert -c ./config source
