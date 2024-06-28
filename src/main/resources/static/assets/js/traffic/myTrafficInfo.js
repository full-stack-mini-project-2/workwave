
const $selectYear = document.getElementById('year');
const currentYear = new Date().getFullYear();

for (let year = currentYear; year >= 2020; year--) {
  const option = document.createElement('option');
  option.setAttribute = ('value', year)
  option.innerText = year + "년";
  $selectYear.appendChild(option);
}

const $selectMonth = document.getElementById('month');

for (let month = 1; month <= 12; month++) {
  const option = document.createElement('option');
  option.setAttribute('value', month);
  option.innerText = month + "월";
  $selectMonth.appendChild(option); 
}



