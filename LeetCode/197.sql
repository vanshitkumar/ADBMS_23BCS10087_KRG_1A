/* Write your T-SQL query statement below */
select today.id from Weather as today
join Weather as yesterday 
on yesterday.recordDate = dateadd(day, -1, today.recordDate)
where today.temperature > yesterday.temperature;
