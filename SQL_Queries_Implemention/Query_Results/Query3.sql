SELECT rewardsReceiptStatus,
       AVG(totalSpent) AS average_spend
FROM Fetchrewards.receipts
-- Considered "FINISHED" as completed
WHERE rewardsReceiptStatus IN ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus;
