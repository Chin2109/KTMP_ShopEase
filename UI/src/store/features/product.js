import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  products: [],
  searchResults: [],
  filterResults: [],
  newArrivalProducts: [],
  isSearching: false,
  isFilter: false,
};

const productSlice = createSlice({
  name: "productState",
  initialState,
  reducers: {
    addProduct: (state, action) => {
      state.products.push(action.payload);
      return state;
    },
    loadProducts: (state, action) => {
      return {
        ...state,
        products: action.payload,
      };
    },
    loadNewArrivalProducts: (state, action) => {
      return {
        ...state,
        newArrivalProducts: action.payload,
      };
    },
    loadSearchResults: (state, action) => {
      state.searchResults = action.payload;
      state.isSearching = true; // đang search
    },
    loadFilterResults: (state, action) => {
      state.filterResults = action.payload;
      state.isFilter = true; // đang search
    },
    clearFilterResults: (state) => {
      state.filterResults = [];
      state.isFilter = false; // reset
    },
    clearSearchResults: (state) => {
      state.searchResults = [];
      state.isSearching = false; // reset
    },
  },
});

export const {
  addProduct,
  loadProducts,
  loadSearchResults,
  clearSearchResults,
  loadNewArrivalProducts,
  loadFilterResults,
  clearFilterResults,
} = productSlice.actions;

export default productSlice.reducer;
