#!/usr/bin/perl

# The Perl script to approve multiple Certificate Signing Requests (CSRs) using an OpenSSL-based Certification Authority (CA)
# Version 1.0
# Copyright 2021 Maxim Masiutin. All rights reserved.

# This program produces a series of commands for OpenSSL to automate CSR processing of multiple requests. You can redirect the output to a batch file (default) and then review and run this batch file. Alternatively, you can modify the final lines of this script to execute the OpenSSL directly from this script.

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.

use strict;

my $approve_csr_command_filename = 'approve_csr.cmd';

my $csr_list= <<END
kube-etcd-hw1-example-com-csr.pem
kube-etcd-hw2-example-com-csr.pem
kube-etcd-hw3-example-com-csr.pem
kube-etcd-hw4-example-com-csr.pem
kube-etcd-hw5-example-com-csr.pem
kube-etcd-hw6-example-com-csr.pem
kube-etcd-hw7-example-com-csr.pem
kube-etcd-hw8-example-com-csr.pem
END
;

my $ossl_prefix;
my $ossl_after_1;
my $ossl_after_2;

open(FH, '<', $approve_csr_command_filename) or die $!;
while(<FH>)
{
  chomp;
  if (/^(openssl ca)([^%]+)%1([^%]+)%2([^%]+)$/)
  {
    $ossl_prefix = $1.$2;
    $ossl_after_1 = $3;
    $ossl_after_2 = $4;
  }
}

close(FH);

if (length($ossl_prefix)<2 || length($ossl_after_1)<2 || length($ossl_after_2)<2)
{
  die "Cannot parse the $approve_csr_command_filename";
}

my @csr_array = split "\n", $csr_list;
undef $csr_list;

my @commands;

foreach my $line (@csr_array) 
{
  if ($line=~/^(.+)(-csr)(\.pem)$/)
  {
    my $infile = $1.$2.$3;
    my $outfile = $1.$3;
    my $command = $ossl_prefix.$infile.$ossl_after_1.$outfile.$ossl_after_2;
    push @commands, $command;
  } else
  {
    die "Cannot parse the line $line";
  }
}

undef @csr_array;
undef $approve_csr_command_filename;
undef $ossl_prefix;
undef $ossl_after_1;
undef $ossl_after_2;

foreach my $command (@commands) 
{
#  `$command`;
  print "$command\n";
}
