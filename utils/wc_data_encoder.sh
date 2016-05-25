for index in {1..100}
do 
  bit_count=0
  mag=index
  while(($mag>=2))
  do
    if [  $[mag%2] = 0 ]; then
	array[$bit_count]=0
	mag=$[mag/2]
    else
	array[$bit_count]=1
	mag=$[mag-1]
	mag=$[mag/2]
    fi
    ((bit_count++))
  done
  array[$bit_count]=1
  echo "$index in binary is ${array[*]}"
  file_name=""
  for data in ${array[@]}
  do
    file_name="${data}""$file_name"
  done

  rest=7-${#array[@]}
  for((i=0;i<rest;i++))
  do
    file_name="0""$file_name"
  done
  file_name="wiki_""$file_name"
  echo "the target file name is $file_name"
  cmd="hdfs dfs -mv /BigDataBench/wordcount/in/lda_wiki1w_$index /BigDataBench/wordcount/in/$file_name"
  echo "executing command:""$cmd"
  $cmd
  echo "Executed!"
done
