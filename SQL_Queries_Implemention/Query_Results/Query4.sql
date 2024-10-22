SELECT receipts.rewardsReceiptStatus,
       SUM(purchasedItemCount) AS total_items
FROM Fetchrewards.receipts
JOIN Fetchrewards.items ON receipts.receiptId = items.receiptId
WHERE receipts.rewardsReceiptStatus IN ('FINISHED', 'REJECTED')
GROUP BY receipts.rewardsReceiptStatus;
