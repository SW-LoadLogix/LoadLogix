import axios from "axios";
import { useAuthStore } from "@/store/auth";
import router from "../router";

// 백엔드의 URL과 포트 설정
const baseURL = process.env.VITE_APP_BASE_URL;

// axios 인스턴스 생성
const axiosInstance = axios.create({
  baseURL: baseURL, // 설정한 baseURL 사용
});

// 비동기 요청 전 인터셉트
axiosInstance.interceptors.request.use(
  (config) => {
    const authStore = useAuthStore();
    config.headers.Authorization = `Bearer ${authStore.token}`;
    return config;
  },
  (error) => Promise.reject(error)
);

// 비동기 요청 응답 수신 시, 인터셉트
axiosInstance.interceptors.response.use(
  (response) => response,
  (error) => {
    if (
      error.response &&
      error.response.data.status === 401 &&
      error.response.data.message === "Token Expired"
    ) {
      const authStore = useAuthStore();
      authStore.clearUser();
      router.push("/login");
      alert("인증이 만료되었습니다. 다시 로그인 해주세요.");
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;