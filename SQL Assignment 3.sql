--SQL Assignment No.3


--1.Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
 
use Jomato

Create procedure PR_01
As
Begin 
Select RestaurantName,RestaurantType,CuisinesType from dbo.Jomato where TableBooking is not null
End;

Exec PR_01


--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.

Use Jomato

Begin Transaction
Update Jomato set CuisinesType='Cafeteria' where CuisinesType Like'Cafe' 
Select CuisinesType from Jomato
Rollback Transaction


--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

SELECT TOP 5
    Area,
    AVG(Rating) AS AvgRating
FROM
    Jomato
GROUP BY
    Area
ORDER BY
    AVG(Rating) DESC;

SELECT TOP 5 ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNumber, Area
FROM Jomato;


--4. Use the while loop to display the 1 to 50.

Declare @counter INT=1;
while @counter<=50
begin
     Print @counter;
     Set @counter =@counter+1;
End;


--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

Create View TopRatingview as 
Select Top 5  * from Jomato 
Order by Rating Desc;

Select *from TopRatingview


--6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted

Create trigger 	Email_Notification
on jomato
after insert
as
begin

EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'XXXX',
@recipients = 'xxxx@gmail.com',
@subject = 'New Record Inserted.',
@body = 'A new record has been inserted.',
@importance ='HIGH'

end



