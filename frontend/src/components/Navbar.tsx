import { FaEthereum } from "react-icons/fa";
import { Link } from "react-router-dom";
import WalletWrapper from "@/helpers/WalletWrapper";
import { WalletSelect } from "@talismn/connect-components";
import {
  AlephZeroWallet,
  EnkryptWallet,
  FearlessWallet,
  MantaWallet,
  NovaWallet,
  PolkadotjsWallet,
  PolkaGate,
  SubWallet,
  TalismanWallet,
} from "@talismn/connect-wallets";

export function Navbar() {
  const DAPP_NAME = "KHOJO";
  return (
    <nav className="fixed top-0 w-full bg-white shadow-sm z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* Logo/Brand */}
          <div className="flex-shrink-0">
            <Link to="/" className="text-xl font-bold flex items-center gap-2">
              <FaEthereum className="text-green text-2xl" />
              ETH Hunt
            </Link>
          </div>

          {/* Navigation Links */}
          <div className="hidden md:flex items-center gap-6">
            <Link to="/" className="text-gray-700 hover:text-green">
              Hunts
            </Link>
            <Link to="/profile" className="text-gray-700 hover:text-green">
              Profile
            </Link>
          </div>

          {/* Wallet Connect */}
          <div className="flex items-center text-black gap-4">
            <WalletWrapper
              className="bg-green text-white rounded-2xl hover:bg-green/80"
              text="Connect Wallet"
              withWalletAggregator={true}
            />
            <WalletSelect
              dappName="Talisman"
              // onlyShowInstalled
              // makeInstallable
              showAccountsList
              walletList={[
                new TalismanWallet(),
                new NovaWallet(),
                new SubWallet(),
                new MantaWallet(),
                new PolkaGate(),
                new FearlessWallet(),
                new EnkryptWallet(),
                new PolkadotjsWallet(),
                new AlephZeroWallet(),
              ]}
              triggerComponent={
                <button className="bg-green font-bold gap-4 rounded-2xl px-4 py-2 hover:bg-green/80">
                  Parachain Wallets
                </button>
              }
            />
          </div>
        </div>
      </div>
    </nav>
  );
}
