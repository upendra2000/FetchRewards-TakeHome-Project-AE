WITH recent_month AS (
    SELECT 
        '2021-01-01'::timestamp AS recent_month
)
  SELECT 
        brands.brandCode AS brandName,
        COUNT(DISTINCT receipts.receiptId) AS receipts_scanned,
        DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT receipts.receiptId) DESC) AS rank
    FROM Fetchrewards.receipts
    JOIN Fetchrewards.items ON receipts.receiptId = items.receiptId
    JOIN Fetchrewards.brands ON items.brandCode = brands.brandCode
    CROSS JOIN recent_month
    WHERE receipts.dateScanned >= recent_month.recent_month  -- For recent month
      AND receipts.dateScanned < recent_month.recent_month + INTERVAL '1 month'
      AND brands.brandCode IS NOT NULL    -- Exclude NULL brandCode
      AND brands.brandCode != ''          -- Exclude empty brandCode
      AND brands.brandCode != 'NaN'       -- Exclude 'NaN' brandCode
    GROUP BY brands.brandCode
    ORDER BY rank
    LIMIT 5;

