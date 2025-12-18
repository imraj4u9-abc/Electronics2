<?php
include 'db.php';
$product = null;

if (isset($_POST['search'])) {
    $device = $_POST['device'];

    $sql = "SELECT * FROM products WHERE name = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$device]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Electronics Online</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h1>🔌 Electronics Online</h1>

    <form method="POST">
        <label class="search-label">Search Electronic Devices</label>
        <input type="text" name="device" placeholder="Enter device name" required>
        <button type="submit" name="search">Search</button>
    </form>

    <?php if ($product): ?>
        <div class="card">
            <img src="<?= htmlspecialchars($product['image_url']) ?>" alt="product">
            <h2><?= htmlspecialchars($product['name']) ?></h2>

            <?php if ($product['available']): ?>
                <p class="available">Item is available</p>
            <?php else: ?>
                <p class="not-available">Item not available</p>
            <?php endif; ?>
        </div>
    <?php elseif (isset($_POST['search'])): ?>
        <p class="not-available">Item not found</p>
    <?php endif; ?>
</div>

</body>
</html>