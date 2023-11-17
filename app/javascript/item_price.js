window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
   priceInput.addEventListener("input", () => {

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 )
    const ProfitDom = document.getElementById("profit");
    ProfitDom.innerHTML = Math.floor(priceInput.value - Math.round(priceInput.value * 0.1 ))
})
});

