import { createBrowserRouter } from "react-router-dom";
import Shop from "./Shop";
import ProtectedRoute from "./components/ProtectedRoute/ProtectedRoute";
import Account from "./pages/Account/Account";
import Orders from "./pages/Account/Orders";
import Profile from "./pages/Account/Profile";
import Settings from "./pages/Account/Settings";
import { AdminPanel } from "./pages/AdminPanel/AdminPanel";
import AuthenticationWrapper from "./pages/AuthenticationWrapper";
import Cart from "./pages/Cart/Cart";
import Checkout from "./pages/Checkout/Checkout";
import ConfirmPayment from "./pages/ConfirmPayment/ConfirmPayment";
import Login from "./pages/Login/Login";
import OAuth2LoginCallback from "./pages/OAuth2LoginCallback";
import OrderConfirmed from "./pages/OrderConfirmed/OrderConfirmed";
import ProductDetails from "./pages/ProductDetailPage/ProductDetails";
import ProductListPage from "./pages/ProductListPage/ProductListPage";
import Register from "./pages/Register/Register";
import ShopApplicationWrapper from "./pages/ShopApplicationWrapper";
import { loadProductBySlug } from "./routes/products";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <ShopApplicationWrapper />,
    children: [
      {
        path: "/",
        element: <Shop />,
      },

      {
        path: "/women",
        element: <ProductListPage categoryType={"Women"} />,
      },
      {
        path: "/men",
        element: <ProductListPage categoryType={"Men"} />,
      },
      {
        path: "/kid",
        element: <ProductListPage categoryType={"Kid"} />,
      },
      {
        path: "/product/:slug",
        loader: loadProductBySlug,
        element: <ProductDetails />,
      },
      {
        path: "/cart-items",
        element: <Cart />,
      },
      {
        path: "/account-details/",
        element: (
          <ProtectedRoute>
            <Account />
          </ProtectedRoute>
        ),
        children: [
          {
            path: "profile",
            element: (
              <ProtectedRoute>
                <Profile />
              </ProtectedRoute>
            ),
          },
          {
            path: "orders",
            element: (
              <ProtectedRoute>
                <Orders />
              </ProtectedRoute>
            ),
          },
          {
            path: "settings",
            element: (
              <ProtectedRoute>
                <Settings />
              </ProtectedRoute>
            ),
          },
        ],
      },
      {
        path: "/checkout",
        element: (
          <ProtectedRoute>
            <Checkout />
          </ProtectedRoute>
        ),
      },
      {
        path: "/orderConfirmed",
        element: <OrderConfirmed />,
      },
    ],
  },
  {
    path: "/v1/",
    element: <AuthenticationWrapper />,
    children: [
      {
        path: "login",
        element: <Login />,
      },
      {
        path: "register",
        element: <Register />,
      },
    ],
  },
  {
    path: "/oauth2/callback",
    element: <OAuth2LoginCallback />,
  },
  {
    path: "/confirmPayment",
    element: <ConfirmPayment />,
  },
  {
    path: "/admin/*",
    element: <AdminPanel />,
  },
]);
