import sys
import os
from collections import defaultdict
import re
from Bio import Phylo 

phylo_tree = open(sys.argv[1], "r") 

#Exporting the tree with edited branches 
tree_dict = {}
tree = Phylo.read(phylo_tree, "newick")
for leaf in tree.get_nonterminals():
	#spplited_names = leaf.name.split("_")
	print leaf
	#leaf.name = "node" + "_" + spplited_names[-1]
	#tree_dict[spplited_names[-2]] = leaf.name
#Phylo.write(tree, "parsed_nwk_tree.nwk", "newick")
