-- Retrieve the top 10 best-selling goods by total sales

SELECT g.goods_name, SUM(si.quantity) as total_quantity, SUM(si.total_price) as total_sales
FROM Sales s
JOIN Sales_Items si ON s.sale_ID = si.sale_ID
JOIN Goods g ON si.goods_ID = g.goods_ID
GROUP BY g.goods_name
ORDER BY total_sales DESC
LIMIT 10;
