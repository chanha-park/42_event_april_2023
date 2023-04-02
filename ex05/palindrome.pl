use strict;
use warnings;

print "Enter a string: ";
my $input = <STDIN>;

if (defined $input)
{

    chomp $input;

    $input = lc $input;

    $input =~ s/\s//g;

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
