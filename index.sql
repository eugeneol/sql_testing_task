CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(6) unsigned NOT NULL,
  `customer_id` int(3) unsigned NOT NULL,
  `currency` varchar(3) NOT NULL,
  `amount` int(4) unsigned NOT NULL,
  `status` varchar(5) NOT NULL,
  primary key (`id`)
  );
INSERT INTO `orders` (`id`, `customer_id`, `currency`, `amount`, `status`) VALUES
  ('1', '1', 'UAH','5', 'pass'),
  ('2', '1', 'UAH', '3', 'fail'),
  ('3', '2', 'USD', '4', 'fail'),
  ('4', '3', 'EUR','2', 'pass');

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(6) unsigned NOT NULL,
  `creation_time` varchar(9) NOT NULL,
  `order_id` int(6) unsigned NOT NULL,
  `is_successful` varchar(6) NOT NULL,
  `data` varchar(5) NOT NULL,
  foreign key (order_id) references `orders`(`id`)
  );
  
 INSERT INTO `transactions` (`id`, `creation_time`, `order_id`, `is_successful`, `data`) VALUES
  ('1', '10:20:12', '2','true', 'pass'),
  ('2', '15:43:34', '3', 'false', 'fail'),
  ('3', '21:10:21', '3', 'false', 'fail'),
  ('4', '10:54:32', '1','true', 'pass'),
  ('5', '11:32:34', '4','false','pass');
  
-- 1):
select * from orders left join
transactions on orders.id = transactions.order_id
where orders.status = 'pass' and transactions.is_successful <> 'true';

-- 2):
select count(transactions.id) as count_trans from orders inner join 
transactions on orders.id = transactions.order_id
where orders.status = 'fail';
-- 3):
(select * from orders inner join
transactions on orders.id = transactions.order_id
where transactions.is_successful = 'false')
union
(select * from orders inner join
transactions on orders.id = transactions.order_id
where transactions.is_successful = 'true'
order by transactions.creation_time desc
limit 1);
