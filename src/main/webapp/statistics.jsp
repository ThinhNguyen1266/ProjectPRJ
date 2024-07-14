<%-- 
    Document   : statistics
    Created on : Jul 14, 2024, 9:35:04 AM
    Author     : AnhNLCE181837
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biểu Đồ Doanh Thu Theo Tháng</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Biểu Đồ Doanh Thu Theo Tháng</h1>
    <label for="yearSelect">Chọn Năm:</label>
    <select id="yearSelect" onchange="updateChart()">
        <option value="2021">2021</option>
        <option value="2022">2022</option>
        <option value="2023">2023</option>
    </select>
    <canvas id="revenueChart" width="400" height="200"></canvas>
    <script>
        const revenueData = {
            '2021': [12, 19, 3, 5, 2, 3, 7, 10, 15, 8, 9, 14],
            '2022': [14, 18, 4, 6, 3, 2, 8, 12, 13, 7, 10, 15],
            '2023': [10, 17, 5, 4, 6, 3, 9, 11, 14, 6, 8, 13]
        };

        const ctx = document.getElementById('revenueChart').getContext('2d');
        let revenueChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [{
                    label: 'Doanh Thu (triệu VND)',
                    data: revenueData['2021'],
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        function updateChart() {
            const selectedYear = document.getElementById('yearSelect').value;
            revenueChart.data.datasets[0].data = revenueData[selectedYear];
            revenueChart.update();
        }
    </script>
</body>
</html>

