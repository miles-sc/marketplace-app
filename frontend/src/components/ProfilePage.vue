<template>
  <div class="profile-container">
    <div class="profile-card">
      <h2>My Profile</h2>

      <div class="profile-info">
        <div class="info-group">
          <label>Name</label>
          <p>{{ user.name }}</p>
        </div>

        <div class="info-group">
          <label>Email</label>
          <p>{{ user.email }}</p>
        </div>

        <div class="info-group" v-if="user.phone">
          <label>Phone</label>
          <p>{{ user.phone }}</p>
        </div>
      </div>

      <button @click="handleLogout" class="btn-logout">
        Logout
      </button>
    </div>
  </div>
</template>

<script>
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

export default {
  name: 'ProfilePage',
  setup() {
    const authStore = useAuthStore()
    const router = useRouter()

    const handleLogout = () => {
      authStore.logout()
      router.push('/login')
    }

    return {
      user: authStore.user,
      handleLogout
    }
  }
}
</script>

<style scoped>
.profile-container {
  display: flex;
  justify-content: center;
  padding: 40px 20px;
}

.profile-card {
  background: white;
  padding: 40px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 500px;
}

h2 {
  margin-top: 0;
  margin-bottom: 30px;
  text-align: center;
  color: #333;
}

.profile-info {
  margin-bottom: 30px;
}

.info-group {
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

.info-group:last-child {
  border-bottom: none;
}

label {
  display: block;
  font-size: 12px;
  text-transform: uppercase;
  color: #888;
  margin-bottom: 5px;
  font-weight: 600;
  letter-spacing: 0.5px;
}

p {
  margin: 0;
  font-size: 16px;
  color: #333;
}

.btn-logout {
  width: 100%;
  padding: 12px;
  background-color: #8B0000;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-logout:hover {
  background-color: #a00000;
}
</style>
