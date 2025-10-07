import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, NavLink, useNavigate } from "react-router-dom";
import { fetchCategories } from "../../api/fetchCategories";
import { searchProducts } from "../../api/fetchProducts";
import { countCartItems } from "../../store/features/cart";
import { loadCategories } from "../../store/features/category";
import { setLoading } from "../../store/features/common";
import {
  clearSearchResults,
  loadSearchResults,
} from "../../store/features/product";
import { AccountIcon } from "../common/AccountIcon";
import { CartIcon } from "../common/CartIcon";
import { Wishlist } from "../common/Wishlist";
import "./Navigation.css";

const Navigation = ({ variant = "default" }) => {
  const capitalize = (str) => str.charAt(0).toUpperCase() + str.slice(1);
  const [query, setQuery] = useState("");
  const dispatch = useDispatch();

  const cartLength = useSelector(countCartItems);
  const navigate = useNavigate();

  const categories = useSelector(
    (state) => state.categoryState.categories || []
  );

  useEffect(() => {
    dispatch(setLoading(true));
    fetchCategories()
      .then((res) => {
        dispatch(loadCategories(res));
      })
      .catch((err) => console.error(err))
      .finally(() => dispatch(setLoading(false)));
  }, [dispatch]);

  const handleSearch = async (e) => {
    e.preventDefault();
    const trimmedQuery = query.trim();
    dispatch(setLoading(true));

    if (!trimmedQuery) {
      dispatch(clearSearchResults()); // reset nếu query rỗng
      dispatch(setLoading(false));
      return;
    }

    try {
      const results = await searchProducts(trimmedQuery);
      dispatch(loadSearchResults(results));
    } catch (err) {
      console.error(err);
      dispatch(clearSearchResults());
    } finally {
      dispatch(setLoading(false));
    }
  };

  return (
    <nav className="flex items-center py-6 px-16 justify-between gap-20 custom-nav">
      <div className="flex items-center gap-6">
        {/* Logo */}
        <a className="text-3xl text-black font-bold gap-8" href="/">
          ShopEase
        </a>
      </div>
      {variant === "default" && (
        <div className="flex flex-wrap items-center gap-10">
          {/* Nav items */}
          <ul className="flex gap-14 text-gray-600 hover:text-black">
            <li>
              <NavLink
                to="/"
                className={({ isActive }) => (isActive ? "active-link" : "")}
              >
                Shop
              </NavLink>
            </li>
            {categories.map((cat) => (
              <li key={cat.id}>
                <NavLink
                  to={`/${cat.name}`}
                  className={({ isActive }) => (isActive ? "active-link" : "")}
                >
                  {capitalize(cat.name)}
                </NavLink>
              </li>
            ))}
          </ul>
        </div>
      )}
      {variant === "default" && (
        <div className="flex justify-center">
          {/* Search bar */}
          <form
            onSubmit={handleSearch}
            className="flex items-center border rounded overflow-hidden"
          >
            <input
              type="text"
              placeholder="Search products..."
              className="px-4 py-2 outline-none"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
            />
            <button type="submit" className="px-4 bg-black text-white">
              Search
            </button>
          </form>
        </div>
      )}

      <div className="flex flex-wrap items-center gap-4">
        {/* Action Items - icons */}
        {variant === "default" && (
          <ul className="flex gap-8 ">
            <li>
              <button>
                <Wishlist />
              </button>
            </li>
            <li>
              <button onClick={() => navigate("/account-details/profile")}>
                <AccountIcon />
              </button>
            </li>
            <li>
              <Link to="/cart-items" className="flex flex-wrap">
                <CartIcon />
                {cartLength > 0 && (
                  <div className="absolute ml-6 inline-flex items-center justify-center h-6 w-6 bg-black text-white rounded-full border-2 text-xs border-white">
                    {cartLength}
                  </div>
                )}
              </Link>
            </li>
          </ul>
        )}
        {variant === "auth" && (
          <ul className="flex gap-8">
            <li className="text-black border border-black hover:bg-slate-100 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 focus:outline-none">
              <NavLink
                to={"/v1/login"}
                className={({ isActive }) => (isActive ? "active-link" : "")}
              >
                Login
              </NavLink>
            </li>
            <li className="text-black border border-black hover:bg-slate-100 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 focus:outline-none">
              <NavLink
                to="/v1/register"
                className={({ isActive }) => (isActive ? "active-link" : "")}
              >
                Signup
              </NavLink>
            </li>
          </ul>
        )}
      </div>
    </nav>
  );
};

export default Navigation;
