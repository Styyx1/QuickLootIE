#pragma once

#include "PluginRequests/RequestClient.h"

namespace QuickLoot::Integrations
{
	class Completionist
	{
	private:
		Completionist() = default;
		~Completionist() = default;

		// For a client request to be processed, both of the following must be true:
		//
		// - client major ver == server major ver
		// - client minor var <= server minor ver
		//
		// Minor version changes must be backwards compatible, so any breaking changes
		// to the api must increase the major version. New handlers may be added by
		// new minor versions.
		static constexpr const char* SERVER_PLUGIN_NAME = "Completionist";
		static constexpr uint16_t API_MAJOR_VERSION = 1;
		static constexpr uint16_t API_MINOR_VERSION = 1;

		static inline PluginRequests::RequestClient _client{};

		// This is the list of request types.
		// Each of them is associated with a signature.
		// The client and server must agree on these signatures.
		enum RequestType : uint32_t
		{
			// General configuration requests
			kGetNeededItemTextColor = 0x11,
			kGetFoundItemTextColor = 0x12,
			kGetDynamicItemTextColor = 0x13,
			kUseNeededItemTextColor = 0x14,
			kUseFoundItemTextColor = 0x15,
			kIsIntegrationEnabled = 0x16,

			// Item specific requests
			kIsItemNeeded = 0x21,
			kIsItemTracked = 0x22,
			kIsItemCollected = 0x23,
			kGetItemDisplayName = 0x24,
		};

	public:
		Completionist(Completionist const&) = delete;
		Completionist(Completionist const&&) = delete;
		Completionist operator=(Completionist&) = delete;
		Completionist operator=(Completionist&&) = delete;

		// The client initialization must happen at (or after) kPostLoad
		static void Init()
		{
			_client.Init(SERVER_PLUGIN_NAME, API_MAJOR_VERSION, API_MINOR_VERSION);
		}

		static bool IsReady()
		{
			return _client.IsReady();
		}

		static uint32_t GetNeededItemTextColor()
		{
			std::uint32_t response = 0;

			if (const auto error = _client.Query(kGetNeededItemTextColor, nullptr, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static uint32_t GetFoundItemTextColor()
		{
			std::uint32_t response = 0;

			if (const auto error = _client.Query(kGetFoundItemTextColor, nullptr, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static uint32_t GetItemDynamicTextColor(RE::FormID formID)
		{
			std::uint32_t response = 0;

			if (const auto error = _client.Query(kGetDynamicItemTextColor, &formID, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static bool IsIntegrationEnabled()
		{
			if (!IsReady()) {
				return false;
			}

			bool response = false;

			if (const auto error = _client.Query(kIsIntegrationEnabled, nullptr, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static bool IsItemNeeded(RE::FormID formID)
		{
			bool response = false;

			if (const auto error = _client.Query(kIsItemNeeded, &formID, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static bool IsItemTracked(RE::FormID formID)
		{
			bool response = false;

			if (const auto error = _client.Query(kIsItemTracked, &formID, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		static bool IsItemCollected(RE::FormID formID)
		{
			bool response = false;

			if (const auto error = _client.Query(kIsItemCollected, &formID, &response)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}

		enum DisplayNameMode : uint32_t
		{
			kLegacyDisplayName = 'LEG',
			kNewDisplayName = 'NEW',
		};

		struct GetItemDisplayName_Request
		{
			RE::FormID formID;
			DisplayNameMode mode;
		};

		static std::string GetItemDisplayName(RE::FormID formID, DisplayNameMode mode)
		{
			const GetItemDisplayName_Request request{ formID, mode };
			std::string response{};

			const PluginRequests::ResponseCallback<char> callback =
				[&response](size_t count, const char* str) {
					SKSE::log::trace("Consumer callback invoked");
					response.assign(str, count);
				};

			if (const auto error = _client.QueryArray(kGetItemDisplayName, &request, callback)) {
				logger::error("Query failed for {}: {}", __func__, _client.GetErrorString(error));
			}

			return response;
		}
	};
}
