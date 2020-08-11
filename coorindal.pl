#!/usr/bin/perl -w
use strict;
use warnings;

die "USAGE:\n $0 <ori_fa> <new_fa> <old_align> <new_align>" unless (@ARGV==4);

open (FAS1,"<$ARGV[0]") or die "$!";
open (FAS2,"<$ARGV[1]") or die "$!";
open (OLD, "<$ARGV[2]") or die "$!";
open (OUT,">$ARGV[3]") or die "$!";

my $old;
while(<FAS1>){
	chomp $_;
	if(!/>/){

		$old.=$_;
	}

}
close FAS1;
my $new;
while(<FAS2>){
	chomp $_;
	if(!/>/){
                 $new.=$_;
	}
}
close FAS2;

while(<OLD>){
	chomp $_;
	my @line=split/\t/,$_;
	my $o_s=$line[1];
	my $o_e=$line[2];
	my $o_l=substr($old,$o_s-1,20);
	my $o_r=substr($old,$o_e-21,20);
	my $n_l=index($new,$o_l);
	my $n_r=index($new,$o_r);
	my $k=0;
	my $m=0;
	   until($n_l!=-1){
		   $k++;
		   $o_l=substr($old,$o_s-1+$k,20);
		   $n_l=index($new,$o_l);
	   }
	   until($n_r!=-1){
		   $m++;
		   $o_r=substr($old,$o_e-1-$m,20);
		   $n_r=index($new,$o_r);
           }
	   $n_l=$n_l+1-$k;
	   $n_r=$n_r+21+$m;
	   print OUT "$line[0]\t$n_l\t$n_r\t$k\t$m\n";
	   @line=();
   }
   close OLD;
   close OUT;

