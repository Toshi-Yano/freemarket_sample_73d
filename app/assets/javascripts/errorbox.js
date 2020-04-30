$(function(){
  (()=>{
    const itemNameInput = document.getElementById('item_name');
    const ebForText_array = Array.from(document.getElementsByClassName('errorbox-fortext__errormessage'));
    const ebForText = ebForText_array[0];
    itemNameInput.addEventListener('blur', () => {
      if (itemNameInput.value === "") {
        itemNameInput.classList.add('not-selected');
        ebForText.classList.add('errorbox-fortext__errormessage__true');
      } else {
        itemNameInput.classList.remove('not-selected');
        ebForText.classList.remove('errorbox-fortext__errormessage__true');
      }
    });
    itemNameInput.addEventListener('input', () => {
      ebForText.classList.remove('errorbox-fortext__errormessage__true');
    });
  
  
    const itemDescriptionInput = document.getElementById('item_description');
    const ebForTextarea_array = Array.from(document.getElementsByClassName('errorbox-fortextarea__errormessage'));
    const ebForTextarea = ebForTextarea_array[0];
    itemDescriptionInput.addEventListener('blur', () => {
      if (itemDescriptionInput.value === "") {
        itemDescriptionInput.classList.add('not-selected');
        ebForTextarea.classList.add('errorbox-fortextarea__errormessage__true');
      } else {
        itemDescriptionInput.classList.remove('not-selected');
        ebForTextarea.classList.remove('errorbox-fortextarea__errormessage__true');
      }
    });
    itemDescriptionInput.addEventListener('input', () => {
      ebForTextarea.classList.remove('errorbox-fortextarea__errormessage__true');
    });
  
  
    const selectNodes = document.querySelectorAll('select');
    const errorNodes = document.getElementsByClassName('errorbox__errormessage');
    const select_array = Array.from(selectNodes);
    const error_array = Array.from(errorNodes);
    select_array.forEach((select, index) => {
      select.classList.add('selectbox__select');
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

    const itemPriceInput = document.getElementById('item_price');
    const ebForPrice_array = Array.from(document.getElementsByClassName('errorbox-forprice__errormessage'));
    const ebForPrice = ebForPrice_array[0];
    let i = 0;
    itemPriceInput.addEventListener('blur', () => {
      if (itemPriceInput.value < 300 || itemPriceInput.value > 9999999) {
        itemPriceInput.classList.add('not-selected');
        ebForPrice.classList.add('errorbox-forprice__errormessage__true');
        i++;
      } else {
        itemPriceInput.classList.remove('not-selected');
        ebForPrice.classList.remove('errorbox-forprice__errormessage__true');
      }
    });
  })();
})