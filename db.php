<?php
$server = "database-1.c7swcswkad0g.ap-northeast-1.rds.amazonaws.com";
$database = "electronics";
$username = "admin";
$password = "Sonali-12398";

try {
    $conn = new PDO(
        "sqlsrv:Server=$server;Database=$database;TrustServerCertificate=true",
        $username,
        $password
    );
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}
?>