import {Chart} from "chart.js/auto"

export class LineChart{
  constructor(ctx, labels,values){
    this.chart = new Chart(ctx, {
      type: 'line',
      data:{
        labels: labels,
        datasets:[
          {
            label: "Wally",
            data: values,
            borderColor: "green",
            backgroundColor: "#C0C0C0",
            fill: true
          }
        ]
      },
      options: {
        scales:{
          x:
            {
              ticks: {
                font: {
                  size:14,
                  weight: "bold"
                }
              }
            }
          ,
          y:
            {
              suggestedMin: 50,
              suggestedMax: 200,
              ticks: {
                font: {
                  size:14,
                  weight: "bold"
                }
              }
            }
          
        }
      }
    })
  }

  addPoint(label, value){
    const labels = this.chart.data.labels;
    const data = this.chart.data.datasets[0].data;

    if(data.length > 12){
      labels.shift();
      data.shift();
    }
    labels.push(label);
    data.push(value);
    this.chart.update()
  }  
}