/*
 * PiFace
 * © 2013 David Given
 * This file is redistributable under the terms of the 3-clause BSD license.
 * See the file 'Copying' in the root of the distribution for the full text.
 */

#include "globals.h"

int main(int argc, const char* argv[])
{
	#if defined TARGET_PI
		pi_init_uart();
	#endif

	init_console();
	newlines_on();

	environ = NULL;
	printf("\n\nPiFace v%s (c) 2013 David Given\n", VERSION);

	/* mmc_init(); */

	for (;;)
	{
		char* buffer;

		printf("> ");
		buffer = readline();

		execute_command(buffer);

		if (error)
			printf("Error: %s\n", error);
		clearError();
	}

	return 0;
}

