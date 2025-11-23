# The Automation Tools for the OpenSSL-based CA

## convert.pl
The `convert.pl` is a Perl script to approve multiple Certificate Signing Requests (CSRs) using an OpenSSL-based Certification Authority (CA). This script produces a series of commands for OpenSSL to automate CSR processing of multiple requests. You can redirect the output to a batch file (default) and then review and run this batch file. Alternatively, you can modify the final lines of this script to execute OpenSSL directly from this script.

## approve_csr.cmd
A sample command file that runs OpenSSL to approve a CSR. It is used as a template for `convert.pl`.
