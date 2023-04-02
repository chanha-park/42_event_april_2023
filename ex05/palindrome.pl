use strict;
use warnings;

print "Enter a string: ";
my $input = <STDIN>;

if (defined $input)
{

    chomp $input;

    my $rev = reverse $input;

    if ($input eq $rev)
    {
        print "\nThe string is a palindrome!\n";
    }
    else
    {
        print "\nThe string is not a palindrome.\n";
    }
}
else
{
    print "\nEOF! need input\n";
}
