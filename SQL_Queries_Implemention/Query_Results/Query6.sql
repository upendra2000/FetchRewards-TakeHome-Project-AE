SELECT * FROM (
    SELECT
        items.brandCode,
        COUNT(items.receiptId) as transaction_count
    FROM Fetchrewards.receipts
    INNER JOIN Fetchrewards.items ON receipts.receiptId = items.receiptId
    WHERE receipts.userId IN (
        SELECT userId
        FROM Fetchrewards.users
        WHERE createdDate > (
            SELECT MAX(createdDate) - INTERVAL '6 months'
            FROM Fetchrewards.users
        )
    )
    AND items.brandCode != 'NaN'  -- Excluding NaN values
    AND items.brandCode IS NOT NULL  -- Excluding NULL values
    GROUP BY items.brandCode
)
ORDER BY transaction_count DESC
LIMIT 3;
