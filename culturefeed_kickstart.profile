<?php

/**
 * @file
 * Installation tasks for this site.
 */

/**
 * Implements hook_install_tasks().
 */
function culturefeed_kickstart_install_tasks(&$install_state) {
  $tasks = array();

  $tasks['culturefeed_kickstart_credentials_form'] = array(
    'display_name' => st('culturefeed_kickstart credentials'),
    'display' => TRUE,
    'type' => 'form',
  );

  return $tasks;
}

/**
 * Form to handle the credentials required to run Culturefeed sites.
 * @param array $form
 * @param array $form_state
 * @param array $install_state
 */
function culturefeed_kickstart_credentials_form($form, &$form_state, &$install_state) {
  
  drupal_set_title(st('CultureFeed credentials'));

  // @todo Get defaults from a webservice in the previous step?
  $defaults = array();
  $defaults += array(
    'culturefeed_search_api_location' => 'http://acc.uitid.be/uitid/rest/searchv2/',
    'culturefeed_search_api_application_key' => 'e36c2db19aeb6d2760ce0500d393e83c',
    'culturefeed_search_api_shared_secret' => 'f0d991505f50d5da23b1157bce133aa9',
    'culturefeed_api_location' => 'http://acc.uitid.be/uitid/rest/',
    'culturefeed_api_application_key' => 'e36c2db19aeb6d2760ce0500d393e83c',
    'culturefeed_api_shared_secret' => 'f0d991505f50d5da23b1157bce133aa9',
  );

  $form['culturefeed'] = array(
    '#type' => 'fieldset',
    '#title' => t('CultureFeed'),
  );
  
  $form['culturefeed']['culturefeed_api_location'] = array(
    '#title' => t('API location'),
    '#type' => t('textfield'),
    '#default_value' => $defaults['culturefeed_api_location'],
    '#description' => t('The URL where the CultuurNet API resides. End with a slash. Example: http://build.uitdatabank.be/'),
    '#element_validate' => array('culturefeed_kickstart_api_location_validate'),
  );

  $form['culturefeed']['culturefeed_api_application_key'] = array(
    '#title' => t('Consumer key'),
    '#type' => 'textfield',
    '#default_value' => $defaults['culturefeed_api_application_key'],
    '#required' => TRUE,
  );

  $form['culturefeed']['culturefeed_api_shared_secret'] = array(
    '#title' => t('Consumer secret'),
    '#type' => 'textfield',
    '#default_value' => $defaults['culturefeed_api_shared_secret'],
    '#required' => TRUE,
  );

  $form['search_api'] = array(
    '#type' => 'fieldset',
    '#title' => t('Search API'),
  );

  $form['search_api']['culturefeed_search_api_location'] = array(
    '#title' => t('API location'),
    '#type' => t('textfield'),
    '#default_value' => $defaults['culturefeed_search_api_location'],
    '#description' => t('The URL where the CultuurNet Search API resides. End with a slash. Example: http://build.uitdatabank.be/'),
    '#element_validate' => array('culturefeed_kickstart_api_location_validate'),
  );

  $form['search_api']['culturefeed_search_api_application_key'] = array(
    '#title' => t('API key'),
    '#type' => 'textfield',
    '#default_value' => $defaults['culturefeed_search_api_application_key'],
    '#required' => TRUE,
    '#description' => t('Your CultureFeed Search API key'),
  );
  
  $form['search_api']['culturefeed_search_api_shared_secret'] = array(
    '#title' => t('Shared secret'),
    '#type' => 'textfield',
    '#default_value' => $defaults['culturefeed_search_api_shared_secret'],
    '#required' => TRUE,
    '#description' => t('Your CultureFeed Search API shared secret'),
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Continue'),
  );

  return $form;
}

/**
 * Validator for the api location.
 * @param array $element
 * @param array $form_state
 * @param array $form
 */
function culturefeed_kickstart_api_location_validate($element, &$form_state, $form) {
  if (!valid_url($element['#value'], TRUE)) {
    return form_error($element, t('!name needs to be a valid URL.', array('!name' => $element['title'])));
  }

  if (drupal_substr($element['#value'], -1) !== '/') {
    return form_error($element, t('!name needs to end with a slash.', array('!name' => $element['title'])));
  }
}

/**
 * Submit function to continue the installation process.
 * @param unknown $form
 * @param unknown $form_state
 */
function culturefeed_kickstart_credentials_form_submit($form, &$form_state) {
  $fieldsets = array('search_api', 'culturefeed');
  foreach ($fieldsets as $fieldset) {
    $children = element_children($form[$fieldset]);

    foreach ($children as $child) {
      variable_set($child, $form_state['values'][$child]);
    }
  }

  // For debugging purposes.
  // Can be replaced with any other kind of log module after installation.
  module_enable(array('dblog'));
}

function culturefeed_kickstart_profile_details(){
  $details['language'] = "nl";
  return $details;
}