function BarChart(ctx, data, labels_x, labels_y) {
  return new Chart(ctx, {
    type: 'bar',
    data: {
      datasets: [{
        data: data,
        backgroundColor: ['#FF0000', '#4B0082', '#0000FF']
      }],
      labels: labels_x
    },
    options: {
      scales: { yAxes: [{ ticks: { beginAtZero: true, max: 4.0, callback: function(value, index, values) { return labels_y[value] } } }] },
      legend: { display: false },
      tooltips: {
        callbacks: {
          label: function(tooltipItem) {
                  return tooltipItem.yLabel;
          }
        }
      }
    }
  });
}

function PieChart(ctx, data, labels) {
  return new Chart(ctx, {
    type: 'pie',
    data: {
      datasets: [{
          data: data,
          backgroundColor: ['#4a010c', '#960038', '#f60239', '#4c9d49', '#005b00', '#000000'],
      }],
      labels: labels
    }
  });
}

function LineChart(ctx, data, labels) {
  return new Chart(ctx, {
    type: 'line',
    data: {
        datasets: [{
            data: data,
            backgroundColor: [
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true,
            stepSize: 1,
            callback: function(value, index, values) { return labels[value] }
          }
        }],
        xAxes: [{
          time: {
            unit: 'day'
          },
          type: 'time',
          distribution: 'linear'
        }]
      },
      legend: { display: false },
    }
  });
}
