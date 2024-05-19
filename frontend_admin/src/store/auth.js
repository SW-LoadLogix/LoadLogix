import { ref } from "vue";
import { defineStore } from "pinia";
import axios from "axios";
import { jwtDecode } from "jwt-decode";

const apiUrl = process.env.VUE_APP_API_URL;

export const useAuthStore = defineStore(
  "auth",
  () => {
    //login User의 정보
    const user = ref({
      id: "", //아이디
      name: "", //이름
      role: "", //직위
    });
    const token = ref(""); //jwt 토큰 정보

    const login = async (loginRequest) => {
      const { data } = await axios.post(`${apiUrl}/login`, loginRequest);

      token.value = data.result.token; //토큰 정보 저장

      const decoded = jwtDecode(token.value); //토큰에서 유저정보 추출하여 유저정보 저장
      user.value.id = decoded.id;
      user.value.name = decoded.name;
      user.value.role = decoded.role;
    };

    const logout = () => {
      clearUser();
    };

    const clearUser = () => {
      user.value.id = "";
      user.value.name = "";
      user.value.role = "";
      token.value = "";
    };

    return { user, token, login, logout, clearUser };
  },

  //새로고침시 데이터 유지를 위한 설정(localStorage에 저장해서 불러오는 방식)
  {
    persist: true,
  }
);
