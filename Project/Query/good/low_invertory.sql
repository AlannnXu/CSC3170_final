-- Get goods with low inventory: (modify threshold_value)

SELECT g.goods_ID, g.goods_name, i.inventory FROM Goods g 
JOIN Inventory i ON g.goods_ID = i.goods_ID 
WHERE i.inventory < 10000;
