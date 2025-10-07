import axios from "axios";
import { API_BASE_URL, API_URLS } from "./constant";

export const fetchCategories = async () => {
  const url = API_BASE_URL + API_URLS.GET_CATEGORIES;

  try {
    const result = await axios(url, {
      method: "GET",
    });
    return result?.data;
  } catch (e) {
    console.log(e);
  }
};

export const fetchCategoryType = async (categoryName) => {
  // gọi hàm API_URLS.GET_CATEGORY_TYPE(categoryName) để lấy path đúng
  const url = API_BASE_URL + `/api/category/type/${categoryName}`;

  try {
    const result = await axios(url, {
      method: "GET",
    }); 
    return result.data;
  } catch (e) {
    console.log(e);
  }
};
