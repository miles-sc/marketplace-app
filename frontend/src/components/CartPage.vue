<template>
  <div class="cart-page">

    <div v-if="cart.items.length === 0">
      <p>Your cart is empty.</p>
    </div>

    <div v-else>
      <div class="checkout-button-wrapper">
        <button class="checkout-button">Proceed to Checkout</button>
      </div>

      <table class="cart-table">
        <thead>
          <tr>
            <th>Part</th>
            <th>Material</th>
            <th>Quantity</th>
            <th>Price</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, idx) in cart.items" :key="idx">
            <td>{{ item.filename }}</td>
            <td>{{ item.material }}</td>
            <td>{{ item.quantity || 1 }}</td>
            <td>{{ fmtMoney(item.price) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { useCartStore } from '@/stores/cart'
const cart = useCartStore()

const currency = new Intl.NumberFormat(undefined, { style: 'currency', currency: 'USD' })
function fmtMoney(n) { return currency.format(Number(n || 0)) }
</script>

<style scoped>
.cart-page {
  max-width: 600px;
  margin: 2rem auto;
  padding: 1rem;
}

.checkout-button-wrapper {
  text-align: center;
  margin-bottom: 1rem;
}

.checkout-button {
  padding: 0.5rem 1.5rem;
  font-size: 1.5rem;
  font-weight: bold;
  background-color: #8B0000;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.checkout-button:hover {
  transform: scale(1.05);
  transition: transform 0.2s ease;
}

.cart-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}

.cart-table th,
.cart-table td {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid #ddd;
  text-align: left;
}

.cart-table th {
  background-color: #f5f5f5;
  font-weight: bold;
}
</style>
