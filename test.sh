#! /ibash
echo ----------------------------------------------------
echo User Name: 정동혁
echo Student Number: 12201797
echo [  Menu ]
echo 1. Get the data of the movie identified by a specific 'movie id' from 'u.item'
echo 2. Get the data of acvtion genre movies from 'u.item'
echo 3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'
echo 4. Delete the 'IMDB URL' from 'u.item'
echo 5. Get the data about users from 'u.item'
echo 6. Modify the format of 'release date' in 'u.item'
echo 7. Get the data of movies rated by a specific 'user id' from 'u.data'
echo 8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 abd 'occupation' as 'programmer'
echo 9. Exit
echo ----------------------------------------------------
read -p "Enter your choice [ 1 ~ 9 ] " reply
while [ $reply != 9 ]
do
	if [ $reply == 1 ]
	then
		echo "
		"
		read -p "Please enter 'movie id' (1~1682):" id
		echo "
		"
		awk -v id="$id" 'NR == id' u.item
		echo "
		"
	fi

	if [ $reply == 2 ] 
	then
		echo "
		"
		read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n):" answer
		if [ $answer == y ]
		then
			awk -F '|' 'NR == 2 || NR == 4 || NR == 17 || NR == 21 || NR == 22 || NR == 24 || NR == 27 || NR == 28 ||NR == 29 || NR == 33 {print $1,$2}' u.item
		echo "
		"
		fi
	fi

	if [ $reply == 3 ]
	then
		echo "
		"
		read -p "Please enter 'movie id' (1~1682):" id 
		awk -v id="$id" '$2 == id {sum += $3; count ++ } END { if (count > 0) printf "average rating of %s", id
		printf ": %.5f\n", sum / count}' u.data
		echo "
		"
	fi

	if [ $reply == 4 ]
	then
		echo "
		"
		read -p "Do you want to get the data about users from 'u.user'?(y/n):" answer
		echo "
		"
		if [ $answer == "y" ]
		then
		sed -n -e '1,10p' u.item | sed 's/http.*)//g'
		echo "
		"
		fi
	fi

	if [ $reply == 5 ]
	then
		echo "
		"
		read -p "Do you want to get the data about ysers from 'u.user'?(y/n):" answer
		echo "
		"
		if [ $answer == y ]
		then
			awk -F '|' 'NR >= 1 && NR <= 10 { id=$1; old=$2; gender=$3; occupation=$4; if (gender == "M") gender = "mail"; else if (gender == "F") gender = "femail"; printf "user %s is", id
			printf " %s years old ", old
			printf "%s ", gender
			printf "%s\n", occupation}' u.user
			echo "
			"
		fi
	fi

	if [ $reply == 6 ]
	then
		echo "
		"
		read -p "Do you want to modify the format of 'release data' in 'u.item'?(y/n):" answer
		echo "
		"
		if [ $answer == y ]
		then  
			sed -n '1673,1683p' u.item |
				sed -E 's/([0-9]+)-([A-Za-z]+)-([0-9]+)/\3-\2-\1/g' | 
				awk -F '-' '{
							if ($2 == "Jan") $2 = "01";
							else if ($2 == "Feb") $2 = "02";
							else if ($2 == "Mar") $2 = "03";
							else if ($2 == "Apr") $2 = "04";
							else if ($2 == "May") $2 = "05";
							else if ($2 == "Jun") $2 = "06";
							else if ($2 == "Jul") $2 = "07";
							else if ($2 == "Aug") $2 = "08";
							else if ($2 == "Sep") $2 = "09";
							else if ($2 == "Oct") $2 = "10";
							else if ($2 == "Nov") $2 = "11";
							else if ($2 == "Dec") $2 = "12";
								print $1$2$3;}'
								echo "
								"
		fi
	fi

	if [ $reply == 7 ]
	then
		read -p "Please enter the 'user id' (1~943):" id
		echo "
		"
		awk -v id="$id" '$1 == id {print $2}' u.data | tr '\n' '|' | tr -s '|' | awk -F '|' '{for (i = 1; i <= NF; i++) a[i] =$i; 
		asort(a); for (i = 1; i<=NF; i++) printf a[i] (i == NF ? "\n" : "|");}' | sed 's/|$//'
		echo "
		"
		awk -v id="$id" '$1 == id {print $2}' u.data | sort -n | head -n 10 | tr '\n' ' ' | xargs -n 1 |
			xargs -I NR sh -c 'awk -v id=NR -F "|" "\$1 == id {print \$1 \"|\" \$2}" u.item' sh
		echo"
		"
	fi

	if [ $reply == 8 ]
	then
		read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'progarmmer'?(y/n):" answer
		if [ $answer == y ]
		then

		fi
	fi
	read -p "Enter your choice [ 1 ~ 9 ] " reply
done
echo Bye !
