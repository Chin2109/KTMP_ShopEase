import axios from "axios";
import { API_BASE_URL, API_URLS } from "./constant";

export const getAllProducts = async (id, typeId) => {
  let url = API_BASE_URL + API_URLS.GET_PRODUCTS + `?categoryId=${id}`;
  if (typeId) {
    url = url + `&typeId=${typeId}`;
  }

  try {
    const result = await axios(url, {
      method: "GET",
    });
    return result?.data;
  } catch (err) {
    console.error(err);
  }
};

export const getProductBySlug = async (slug) => {
  const url = API_BASE_URL + API_URLS.GET_PRODUCTS + `?slug=${slug}`;
  try {
    const result = await axios(url, {
      method: "GET",
    });
    return result?.data?.[0];
  } catch (err) {
    console.error(err);
  }
};

export const searchProducts = async (query) => {
  const url = `${API_BASE_URL}/api/products/search?name=${encodeURIComponent(
    query
  )}`;
  try {
    const res = await axios.get(url);
    return res?.data;
  } catch (err) {
    console.error("Search error:", err);
    return [];
  }
};

export const filterProducts = async ({
  categoryType,
  minPrice,
  maxPrice,
  color,
  size,
}) => {
  const params = new URLSearchParams();
  if (categoryType) params.append("categoryType", categoryType);
  if (minPrice) params.append("minPrice", minPrice);
  if (maxPrice) params.append("maxPrice", maxPrice);
  if (color) params.append("color", color);
  if (size) params.append("size", size);

  const url = `${API_BASE_URL}/api/products/search?${params.toString()}`;
  try {
    const res = await axios.get(url);
    return res.data;
  } catch (err) {
    console.error(err);
    return [];
  }
};

export const getNewArrivals = async () => {
  try {
    const res = await axios.get(`${API_BASE_URL}/api/products/newArrivals`);
    return res?.data || [];
  } catch (err) {
    console.error("Error fetching new arrivals:", err);
    return [];
  }
};
