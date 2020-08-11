#!/usr/bin/perl -w
use strict;
use warnings;
die "USAGE:\n $0 <IN> <OUT>" unless (@ARGV==2);
open(IN, "<$ARGV[0]") or die "$!";
open(OUT,">$ARGV[1]") or die "$!";
my @arr;
while(<IN>){
	  chomp $_;
	  push @arr,$_;
	  if($#arr==1){
	     my  $start=(split/\t/,$arr[0])[-1]+1;
	     my  $end=(split/\t/,$arr[1])[1]-1;
		  print OUT "noncoding\t$start\t$end\n";
                  shift @arr;
	 }
 }	 
