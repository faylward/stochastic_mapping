import os, sys, re
from Bio import Phylo
from collections import defaultdict

def get_parent(tree, child_clade):
    node_path = tree.get_path(child_clade)
    return node_path[-2]

tree = Phylo.read('tree.acc.nwk', 'newick')
#clades = [i for i in tree.find_clades()]
clades = tree.get_nonterminals()

number = 0
for node in clades:
	support = node.confidence
	branch_length = 0
	node_path = tree.get_path(node)
	number +=1
	node.name = "Node_"+str(number)

Phylo.write(tree, "parsed_nwk_tree.nwk", "newick")

#	for parent in node_path:
#		length = parent.branch_length
#		branch_length = branch_length + length
#	print str(node) +"\t"+ str(support) +"\t"+ str(branch_length) #, node_path
		
#Phylo.write(tree, "newtree.nwk", "newick")
