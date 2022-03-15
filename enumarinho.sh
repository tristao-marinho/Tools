#!/bin/bash 
echo "###Programa criado para fazer enumeração de dominios e subdominios"
echo "###versão 1.0"
echo "###Author Tristão Marinho"
target=$1
echo "Alvo $target"
echo "iniciando"

#echo " ">enum-log-subdominios.txt
#for test in $(cat dns.txt)
#	do
#	echo "testando $test.$target"
#	host $test.$target |  grep "has address"  | cut -d' ' -f1 | head -n1
#		if [ $? -eq 0 ];
#			then
#				echo `host $test.$target |   grep "has address"  | cut -d' ' -f1 | head -n1 `>>enum-log-subdominios.txt
#				
#			else
#			echo "erro"	>/dev/null
#		fi
#		done

for test in $(cat dns-wordlist.txt)
	do
	echo "testando $target/$test/ $direct"
	direct=$(curl -o /dev/null -s -w %{http_code} https://www.$target/$test/)

	if [ $direct != 404  ];
			then
				echo "https://www.$target/$test/ + $direct">>$1.txt
			else
			echo "erro"	>/dev/null
		fi
		done
	
for past in $(cat enum-log-subdominios.txt)
	do
	echo $past>>$1.txt
		for test in $(cat dns-wordlist.txt)
	do
	echo "testando $past/$test/"
	direct=$(curl -o /dev/null -s -w %{http_code} https://$past/$test/)
	if [ $direct != 404  ];
			then
				echo "https://$past/$test/">>$1.txt
			else
			echo "erro"	>/dev/null
		fi
		done
	
		done
rm 		enum-log-subdominios.txt
