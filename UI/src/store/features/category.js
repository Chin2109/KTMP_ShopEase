import { createSlice } from "@reduxjs/toolkit";

export const initialState = {
  categories: [],
  categoryType: [],
};

export const categorySlice = createSlice({
  name: "categoryState",
  initialState,
  reducers: {
    loadCategories: (state, action) => {
      return {
        ...state,
        categories: action?.payload,
      };
    },
    loadCategoryType: (state, action) => {
      return {
        ...state,
        categoryType: action?.payload,
      };
    },
  },
});

export const { loadCategories, loadCategoryType } = categorySlice?.actions;

export default categorySlice?.reducer;
