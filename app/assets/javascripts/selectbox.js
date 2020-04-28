(()=>{
  const selectNodes = document.querySelectorAll('select');
  const errorNodes = document.getElementsByClassName('errorbox__errormessage');
  const select_array = Array.from(selectNodes);
  const error_array = Array.from(errorNodes);

  select_array.forEach((select, index) => {
    select.addEventListener('blur', () => {
      if (select.value === "") {
        select.classList.add("not-selected");
        error_array[index].classList.add('errorbox__errormessage__true');
      } else {
        select.classList.remove("not-selected");
        error_array[index].classList.remove('errorbox__errormessage__true');
      }
    });
  });
})();