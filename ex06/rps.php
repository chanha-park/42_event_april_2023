<?php

echo "Choose rock, paper, or scissors: ";

$choices = array();

$choices[0] = "rock";
$choices[1] = "paper";
$choices[2] = "scissors";

$userchoice = fgets(STDIN);

// echo $userchoice;

$userchoice = trim($userchoice);

$computer = rand() % 3;

// echo $computer;

if (strcmp("rock", $userchoice) == 0)
{
    $user = 0;
}
else if (strcmp("paper", $userchoice) == 0)
{
    $user = 1;
}
else if (strcmp("scissors", $userchoice) == 0)
{
    $user = 2;
}
else
{
    echo "try again\n";
    exit(1);
}

if ($user == ($computer + 1) % 3)
{
    $msg = "Congratulations! You won!";
}
else if ($computer == ($user + 1) % 3)
{
    $msg = "Sorry, you lost.";
}
else
{
    $msg = "Try again, tie.";
}

echo "{$msg} The computer chose {$choices[$computer]}.\n";

?>
