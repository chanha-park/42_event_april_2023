#include <stdio.h>

int	calculate_score(char *input, int score, int number_of_eleven)
{
	if (*input)
	{
		if (*input >= '2' && *input <= '9')
		{
			return (calculate_score(input + 1, score + *input - '0', number_of_eleven));
		}
		else if (*input == 'T' || *input == 'J' || *input == 'D' || *input == 'K')
		{
			return (calculate_score(input + 1, score + 10, number_of_eleven));
		}
		else if (*input == 'A')
		{
			return (calculate_score(input + 1, score + 11, number_of_eleven + 1));
		}
		else
		{
			return (-1);
		}
	}
	else
	{
		if (score > 21 && number_of_eleven > 0)
		{
			return (calculate_score(input, score - 10, number_of_eleven - 1));
		}
		else
		{
			return (score);
		}
	}
}

int main(int argc, char **argv)
{
	int	score;

	if (argc == 2)
	{
		score = calculate_score(argv[1], 0, 0);
		if (score < 0)
		{
			printf("Input Error\n");
		}
		else if (score == 21)
		{
			printf("Blackjack!\n");
		}
		else
		{
			printf("%d\n", score);
		}
	}
	else
	{
		printf("Input Error\n");
	}
	return (0);
}
