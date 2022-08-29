with open("wordlist.txt", "r") as wordlist:
	lines = wordlist.readlines()

lines_clean = []

for item in lines:
	lines_clean.append(item.strip('\n'))

first_words = lines_clean
second_words = lines_clean
third_words = lines_clean

for first_word in first_words:
	for second_word in second_words:
		for third_word in third_words:
			print(f'{first_word}{second_word}{third_word}')