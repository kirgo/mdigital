<?php

class FuelSaverApi
{
	protected $curl;
	protected $baseUrl;
	protected $lastError; 
	protected $uuid;
	
	public function __construct ($baseUrl) {
		filter_var_array ($_POST, FILTER_SANITIZE_STRING);
		filter_var_array ($_GET, FILTER_SANITIZE_STRING);
		
		$this->baseUrl = $baseUrl;
		$this->uuid = null;
	}
	
	public function getConfig () {
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, $this->baseUrl . '/config');
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		$code = curl_getinfo($this->ch, CURLINFO_HTTP_CODE);
		$config = curl_exec ($this->ch);
		curl_close ($this->ch);
		if ($code == 200 || $code == 0) {
			return new SimpleXMLElement ($config);
		}
		return false;
	}
	
	public function getUUID () {
		if ($this->uuid) {
			return $this->uuid;
		} else if (isset ($_SESSION) && isset ($_SESSION['uuid'])) {
			$this->uuid = $_SESSION['uuid'];
			return $this->uuid;
		}
		
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, $this->baseUrl . '/uuid');
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt ($this->ch, CURLOPT_USERAGENT, $_SERVER ['HTTP_USER_AGENT']);
		$remoteAddress = $ip = isset( $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'] ) ? $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'] : $_SERVER['REMOTE_ADDR']; 
		curl_setopt ($this->ch, CURLOPT_HTTPHEADER, 
			array("REMOTE_ADDR: $remoteAddress", "HTTP_X_FORWARDED_FOR: $remoteAddress"));
		$code = curl_getinfo($this->ch, CURLINFO_HTTP_CODE);
		
		$uuid = curl_exec ($this->ch);
		$uuidXML = new SimpleXMLElement ($uuid);
		$this->uuid = (string) $uuidXML [0];
		if (isset ($_SESSION)) {
			$_SESSION ['uuid'] = $this->uuid;
		}
		
		curl_close ($this->ch);
		if ($code == 200) {
			return $this->uuid;
		}
		return false;
	}
	
	public function findStores () {
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, 
			$this->baseUrl . '/' . $this->uuid. '/stores?' . http_build_query ($_POST));
		curl_setopt ($this->ch, CURLOPT_CUSTOMREQUEST, "GET");
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt ($this->ch, CURLOPT_USERAGENT, $_SERVER ['HTTP_USER_AGENT']);
		$response = curl_exec ($this->ch);
		$code = curl_getinfo($this->ch, CURLINFO_HTTP_CODE);
		curl_close ($this->ch);
		if ($code == 200) {
			return new SimpleXMLElement ($response);
		}
		return false;
	}
	
	public function calculate () {
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, $this->baseUrl . '/' . $this->uuid. '/calculate?' . http_build_query ($_POST));
		curl_setopt ($this->ch, CURLOPT_CUSTOMREQUEST, "GET");
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		$response = curl_exec ($this->ch);
		$code = curl_getinfo ($this->ch, CURLINFO_HTTP_CODE);
		curl_close ($this->ch);
		if ($code == 200) {
			return new SimpleXMLElement ($response);
		}
		return false;
	}
	
	public function collect () {
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, $this->baseUrl . '/' . $this->uuid. '/collect');
		curl_setopt ($this->ch, CURLOPT_CUSTOMREQUEST, "POST");
		curl_setopt ($this->ch, CURLOPT_POSTFIELDS, $_POST);
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		$response = curl_exec ($this->ch);
		$code = curl_getinfo($this->ch, CURLINFO_HTTP_CODE);
		curl_close ($this->ch);
		if ($code == 200) {
			return true;
		}
		return false;
	}
	
	public function sliderTrack () {
		$this->ch = curl_init ();
		curl_setopt ($this->ch, CURLOPT_URL, $this->baseUrl . '/' . $this->uuid. '/slider-track');
		curl_setopt ($this->ch, CURLOPT_CUSTOMREQUEST, "POST");
		curl_setopt ($this->ch, CURLOPT_POSTFIELDS, $_POST);
		curl_setopt ($this->ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt ($this->ch, CURLOPT_FOLLOWLOCATION, true);
		$response = curl_exec ($this->ch);
		$code = curl_getinfo($this->ch, CURLINFO_HTTP_CODE);
		curl_close ($this->ch);
		if ($code == 200) {
			return $response;
		}
		return false;
	}
	
	
}