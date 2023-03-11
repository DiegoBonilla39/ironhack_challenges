# Pandas Apply Lambda

The ultimate tool when leading with a [Pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/index.html) dataframe!!!

![Image](http://www.potacho.com/files/ironhack/pandas.JPG)

---

## **Using the apply function with lambda**
The general syntax is: 

```
df.apply(lambda x: func( x['col1'], x['col2']), axis=1 )
```

> This will allow you to create pretty much any logic, I promise!!! 

### :file_folder: **Data**
To perform the challenges you will use the dataset `/data/input/IMDB-Movie-Data.csv`

### :panda_face: **Challenge 1. Warm up**
We want to create **bins** of movies according to the number of votes they've received. For that matter, we will create a new column named **'bin'** which will tag every movie as follow:
- From 0 to 999 ==> 1
- From 1000 to 9999 ==> 2
- From 10000 to 99999 ==> 3
- From 100000 to 999999 ==> 4
- More than 1000000 ==> 5 

### :panda_face: :panda_face: **Challenge 2. Using axis concept**
We want to know how much is the revenue per minute for every movie.

### :panda_face: :panda_face: :panda_face: **Challenge 3. Using the lambda**
We want to create a new ranking where we add 1 point if the genre is thriller but subtract 1 point if the genre is comedy.

### :panda_face: :panda_face: :panda_face: :panda_face: **Challenge 4. Now the real stuff**
We want to know if the sum of the ASCII value of every character of the movie title divided by the number of votes retrieve a prime number...remember, prime numbers are integers.

### :panda_face: :panda_face: :panda_face: :panda_face: :panda_face: **Challenge 5. And finally some fantasy**
Feel free to propose your own ranking based in aggregations of at least 3 columns of the dataset.

### :panda_face: :panda_face: :panda_face: :panda_face: :panda_face: :panda_face: **Challenge 6. Freaky bonus**
We want to know which movies might have hidden paterns in their description. A way to know that is finding those movies which the sum of all numeric values of the string description hash (SHA256) are between their revenue and their number of votes.   


---


